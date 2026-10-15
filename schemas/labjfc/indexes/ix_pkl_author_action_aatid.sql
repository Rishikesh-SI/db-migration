-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_author_action_aatid
-- Type: INDEX

-- Name: ix_pkl_author_action_aatid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_author_action_aatid ON labjfc.labjfc_author_action USING btree (asset_id, asset_type_id);


--
