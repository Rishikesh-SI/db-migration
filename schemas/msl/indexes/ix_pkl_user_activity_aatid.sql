-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: ix_pkl_user_activity_aatid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aatid; Type: INDEX; Schema: msl; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aatid ON msl.msl_user_activity USING btree (asset_id, asset_type_id);


--
