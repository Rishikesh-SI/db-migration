-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_user_role_rid
-- Type: INDEX

-- Name: ix_ttmum_user_role_rid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_user_role_rid ON labw88.labw88_user_role USING btree (role_id);


--
