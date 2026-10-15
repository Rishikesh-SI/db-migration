-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_author_action_aatid
-- Type: INDEX

-- Name: ix_kxp_author_action_aatid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_author_action_aatid ON labkxp1.labkxp_author_action USING btree (asset_id, asset_type_id);


--
