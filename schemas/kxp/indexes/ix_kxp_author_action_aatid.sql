-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_author_action_aatid
-- Type: INDEX

-- Name: ix_kxp_author_action_aatid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_author_action_aatid ON kxp.kxp_author_action USING btree (asset_id, asset_type_id);


--
