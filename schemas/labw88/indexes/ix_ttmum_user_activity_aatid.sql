-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labw88.labw88_user_activity USING btree (asset_id, asset_type_id);


--
