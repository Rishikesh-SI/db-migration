-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_author_action_aatid
-- Type: INDEX

-- Name: ix_tsk_author_action_aatid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_author_action_aatid ON tsk.tsk_author_action USING btree (asset_id, asset_type_id);


--
