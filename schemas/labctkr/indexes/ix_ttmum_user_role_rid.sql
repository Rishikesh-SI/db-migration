-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labctkr.labctkr_user_role USING btree (role_id);


--
