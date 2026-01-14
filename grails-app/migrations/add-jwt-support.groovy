/**
 * Grails Database Migration Script
 * Adds JWT and refresh token support to StreamFit
 *
 * Execute manually or use Liquibase migration runner
 */

changeSet(author: 'jwt-implementation', id: 'add-refresh-token-table') {

    // Create refresh_token table
    createTable(tableName: 'refresh_token') {
        column(name: 'id', type: 'BIGINT', autoIncrement: true, remarks: 'Primary key') {
            constraints(primaryKey: true, nullable: false)
        }
        column(name: 'token_id', type: 'VARCHAR(255)', remarks: 'UUID token identifier') {
            constraints(nullable: false, unique: true)
        }
        column(name: 'user_id', type: 'BIGINT', remarks: 'Foreign key to streamfit_user') {
            constraints(nullable: false)
        }
        column(name: 'token', type: 'LONGTEXT', remarks: 'Hashed refresh token value') {
            constraints(nullable: false)
        }
        column(name: 'expires_at', type: 'TIMESTAMP', remarks: 'Token expiration time') {
            constraints(nullable: false)
        }
        column(name: 'created_at', type: 'TIMESTAMP', remarks: 'Token creation time', defaultValueComputed: 'CURRENT_TIMESTAMP') {
            constraints(nullable: false)
        }
        column(name: 'revoked_at', type: 'TIMESTAMP', remarks: 'Token revocation time (null if active)')
        column(name: 'ip_address', type: 'VARCHAR(45)', remarks: 'IP address where token was issued')
        column(name: 'user_agent', type: 'VARCHAR(500)', remarks: 'User agent where token was issued')
        column(name: 'rotation_count', type: 'INT', defaultValue: '0', remarks: 'Number of rotations') {
            constraints(nullable: false)
        }
        column(name: 'parent_token_id', type: 'VARCHAR(255)', remarks: 'Parent token in rotation chain')
    }

    // Add indexes
    createIndex(tableName: 'refresh_token', indexName: 'user_id_idx') {
        column(name: 'user_id')
    }
    createIndex(tableName: 'refresh_token', indexName: 'token_id_idx') {
        column(name: 'token_id')
    }
    createIndex(tableName: 'refresh_token', indexName: 'expires_at_idx') {
        column(name: 'expires_at')
    }
    createIndex(tableName: 'refresh_token', indexName: 'revoked_at_idx') {
        column(name: 'revoked_at')
    }

    // Add foreign key
    addForeignKeyConstraint(
        baseTableName: 'refresh_token',
        baseColumnNames: 'user_id',
        constraintName: 'refresh_token_user_id_fk',
        referencedTableName: 'streamfit_user',
        referencedColumnNames: 'id'
    )
}

changeSet(author: 'jwt-implementation', id: 'add-jwt-tracking-to-user') {

    // Add JWT/auth tracking columns to streamfit_user
    addColumn(tableName: 'streamfit_user') {
        column(name: 'last_login_at', type: 'TIMESTAMP', remarks: 'Last login timestamp')
        column(name: 'last_logout_at', type: 'TIMESTAMP', remarks: 'Last logout timestamp')
        column(name: 'last_login_ip', type: 'VARCHAR(45)', remarks: 'IP address of last login')
        column(name: 'failed_login_attempts', type: 'INT', defaultValue: '0', remarks: 'Count of failed login attempts') {
            constraints(nullable: false)
        }
        column(name: 'last_failed_login_at', type: 'TIMESTAMP', remarks: 'Timestamp of last failed login')
    }

    // Add indexes for auth tracking
    createIndex(tableName: 'streamfit_user', indexName: 'last_login_at_idx') {
        column(name: 'last_login_at')
    }
}

// SQL equivalent if running manually:
/*

-- Create refresh_token table
CREATE TABLE refresh_token (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  token_id VARCHAR(255) UNIQUE NOT NULL,
  user_id BIGINT NOT NULL,
  token LONGTEXT NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  revoked_at TIMESTAMP NULL,
  ip_address VARCHAR(45),
  user_agent VARCHAR(500),
  rotation_count INT DEFAULT 0,
  parent_token_id VARCHAR(255),
  INDEX user_id_idx (user_id),
  INDEX token_id_idx (token_id),
  INDEX expires_at_idx (expires_at),
  INDEX revoked_at_idx (revoked_at),
  CONSTRAINT refresh_token_user_id_fk
    FOREIGN KEY (user_id) REFERENCES streamfit_user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add JWT tracking columns to streamfit_user
ALTER TABLE streamfit_user ADD COLUMN (
  last_login_at TIMESTAMP NULL,
  last_logout_at TIMESTAMP NULL,
  last_login_ip VARCHAR(45),
  failed_login_attempts INT DEFAULT 0,
  last_failed_login_at TIMESTAMP NULL
);

CREATE INDEX last_login_at_idx ON streamfit_user(last_login_at);

*/

