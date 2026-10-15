-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_user_activity_aatid
-- Type: INDEX

-- Name: ix_stn_user_activity_aatid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_user_activity_aatid ON stn.stn_user_activity USING btree (asset_id, asset_type_id);


--
