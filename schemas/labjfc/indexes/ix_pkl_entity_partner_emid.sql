-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_entity_partner_emid
-- Type: INDEX

-- Name: ix_pkl_entity_partner_emid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_entity_partner_emid ON labjfc.labjfc_entity_language_map USING btree (entity_master_id);


--
