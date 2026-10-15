-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_user_role_uid
-- Type: INDEX

-- Name: ix_upp_user_role_uid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_user_role_uid ON upp.upp_user_role USING btree (user_id);


--
