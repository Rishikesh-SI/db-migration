-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_user_role_uid
-- Type: INDEX

-- Name: ix_scup_user_role_uid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_user_role_uid ON u17wc.u17wc_user_role USING btree (user_id);


--
