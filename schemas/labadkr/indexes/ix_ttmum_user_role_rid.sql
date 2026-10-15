-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labadkr.labadkr_user_role USING btree (role_id);


--
