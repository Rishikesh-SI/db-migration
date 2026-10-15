-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labkc; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labkc.labkc_user_role USING btree (role_id);


--
