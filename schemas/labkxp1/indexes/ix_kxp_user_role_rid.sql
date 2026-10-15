-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_user_role_rid
-- Type: INDEX

-- Name: ix_kxp_user_role_rid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_user_role_rid ON labkxp1.labkxp_user_role USING btree (role_id);


--
