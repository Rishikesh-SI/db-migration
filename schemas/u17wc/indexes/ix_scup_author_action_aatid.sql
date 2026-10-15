-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_author_action_aatid
-- Type: INDEX

-- Name: ix_scup_author_action_aatid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_author_action_aatid ON u17wc.u17wc_author_action USING btree (asset_id, asset_type_id);


--
