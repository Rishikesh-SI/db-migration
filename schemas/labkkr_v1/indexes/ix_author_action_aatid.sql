-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labkkr_v1; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labkkr_v1.labkkr_v1_author_action USING btree (asset_type_id, asset_id);


--
