-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_user_role_uid
-- Type: INDEX

-- Name: ix_rfg_user_role_uid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_user_role_uid ON rfg.rfg_user_role USING btree (user_id);


--
