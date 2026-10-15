-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_user_role_uid
-- Type: INDEX

-- Name: ix_kxp_user_role_uid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_user_role_uid ON kxp.kxp_user_role USING btree (user_id);


--
