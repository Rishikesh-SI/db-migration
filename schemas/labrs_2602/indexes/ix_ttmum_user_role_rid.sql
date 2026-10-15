-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labrs_2602; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labrs_2602.labrs_user_role USING btree (role_id);


--
