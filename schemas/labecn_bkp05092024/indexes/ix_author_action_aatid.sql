-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_bkp05092024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labecn_bkp05092024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labecn_bkp05092024.labecn_author_action USING btree (asset_type_id, asset_id);


--
