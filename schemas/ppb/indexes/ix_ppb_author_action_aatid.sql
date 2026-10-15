-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_author_action_aatid
-- Type: INDEX

-- Name: ix_ppb_author_action_aatid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_author_action_aatid ON ppb.ppb_author_action USING btree (asset_id, asset_type_id);


--
