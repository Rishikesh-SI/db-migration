-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labgmr_01082024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labgmr_01082024.labgmr_author_action USING btree (asset_type_id, asset_id);


--
