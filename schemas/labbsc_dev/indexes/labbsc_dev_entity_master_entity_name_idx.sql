-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_entity_master_entity_name_idx
-- Type: INDEX

-- Name: labbsc_dev_entity_master_entity_name_idx; Type: INDEX; Schema: labbsc_dev; Owner: -
--

CREATE INDEX labbsc_dev_entity_master_entity_name_idx ON labbsc_dev.labbsc_dev_entity_master USING btree (entity_name);


--
