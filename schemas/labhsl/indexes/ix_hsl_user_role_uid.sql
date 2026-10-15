-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_user_role_uid
-- Type: INDEX

-- Name: ix_hsl_user_role_uid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_user_role_uid ON labhsl.labhsl_user_role USING btree (user_id);


--
