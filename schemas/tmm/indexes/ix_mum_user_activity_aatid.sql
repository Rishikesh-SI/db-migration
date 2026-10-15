-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: ix_mum_user_activity_aatid
-- Type: INDEX

-- Name: ix_mum_user_activity_aatid; Type: INDEX; Schema: tmm; Owner: -
--

CREATE INDEX ix_mum_user_activity_aatid ON tmm.tmm_user_activity USING btree (asset_id, asset_type_id);


--
