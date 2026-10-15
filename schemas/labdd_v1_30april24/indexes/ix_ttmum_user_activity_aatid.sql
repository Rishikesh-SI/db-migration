-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: ix_ttmum_user_activity_aatid
-- Type: INDEX

-- Name: ix_ttmum_user_activity_aatid; Type: INDEX; Schema: labdd_v1_30april24; Owner: -
--

CREATE INDEX ix_ttmum_user_activity_aatid ON labdd_v1_30april24.labdd_v1_user_activity USING btree (asset_id, asset_type_id);


--
