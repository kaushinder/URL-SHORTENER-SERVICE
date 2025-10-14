ALTER TABLE "urls" DROP CONSTRAINT "urls_id_not_null";--> statement-breakpoint
ALTER TABLE "urls" DROP CONSTRAINT "urls_code_not_null";--> statement-breakpoint
ALTER TABLE "urls" DROP CONSTRAINT "urls_target_url_not_null";--> statement-breakpoint
ALTER TABLE "urls" DROP CONSTRAINT "urls_user_id_not_null";--> statement-breakpoint
ALTER TABLE "urls" DROP CONSTRAINT "urls_created_at_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_id_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_first_name_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_email_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_password_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_salt_not_null";--> statement-breakpoint
ALTER TABLE "users" DROP CONSTRAINT "users_created_at_not_null";--> statement-breakpoint
ALTER TABLE "urls" ADD CONSTRAINT "urls_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;