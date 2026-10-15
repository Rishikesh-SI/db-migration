-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_author_action_aatid ON stn.stn_author_action USING btree (asset_type_id, asset_id);


--
