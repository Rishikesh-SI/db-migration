-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_user_activity_aatid
-- Type: INDEX

-- Name: ix_pkl_user_activity_aatid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_user_activity_aatid ON labpkl.labpkl_user_activity USING btree (asset_id, asset_type_id);


--
