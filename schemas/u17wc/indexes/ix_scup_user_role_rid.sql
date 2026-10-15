-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_user_role_rid
-- Type: INDEX

-- Name: ix_scup_user_role_rid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_user_role_rid ON u17wc.u17wc_user_role USING btree (role_id);


--
