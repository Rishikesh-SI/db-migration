-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: idx_entity_name_vector
-- Type: INDEX

-- Name: idx_entity_name_vector; Type: INDEX; Schema: labfih; Owner: -
--

CREATE INDEX idx_entity_name_vector ON labfih.labfih_entity_master USING gin (entity_name_vector);


--
