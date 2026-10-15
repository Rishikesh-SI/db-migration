-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_user_activity_aatid
-- Type: INDEX

-- Name: ix_tsk_user_activity_aatid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_user_activity_aatid ON tsk.tsk_user_activity USING btree (asset_id, asset_type_id);


--
