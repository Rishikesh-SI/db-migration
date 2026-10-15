-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_author_action_aatid
-- Type: INDEX

-- Name: ix_author_action_aatid; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX ix_author_action_aatid ON labyho.labyho_author_action USING btree (asset_type_id, asset_id);


--
