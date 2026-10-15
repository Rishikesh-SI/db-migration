-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labkkr_30012024; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labkkr_30012024.labkkr_author_action USING btree (asset_type_id, asset_id);


--
