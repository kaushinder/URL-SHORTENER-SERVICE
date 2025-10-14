-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*
CREATE TABLE "urls" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" varchar(155) NOT NULL,
	"target_url" text NOT NULL,
	"user_id" uuid NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp,
	CONSTRAINT "urls_code_unique" UNIQUE("code"),
	CONSTRAINT "urls_id_not_null" CHECK (NOT NULL id),
	CONSTRAINT "urls_code_not_null" CHECK (NOT NULL code),
	CONSTRAINT "urls_target_url_not_null" CHECK (NOT NULL target_url),
	CONSTRAINT "urls_user_id_not_null" CHECK (NOT NULL user_id),
	CONSTRAINT "urls_created_at_not_null" CHECK (NOT NULL created_at)
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"first_name" varchar(55) NOT NULL,
	"last_name" varchar(55),
	"email" varchar(255) NOT NULL,
	"password" text NOT NULL,
	"salt" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp,
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_id_not_null" CHECK (NOT NULL id),
	CONSTRAINT "users_first_name_not_null" CHECK (NOT NULL first_name),
	CONSTRAINT "users_email_not_null" CHECK (NOT NULL email),
	CONSTRAINT "users_password_not_null" CHECK (NOT NULL password),
	CONSTRAINT "users_salt_not_null" CHECK (NOT NULL salt),
	CONSTRAINT "users_created_at_not_null" CHECK (NOT NULL created_at)
);

*/