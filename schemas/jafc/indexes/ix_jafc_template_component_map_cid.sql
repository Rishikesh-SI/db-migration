-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_template_component_map_cid
-- Type: INDEX

-- Name: ix_jafc_template_component_map_cid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_template_component_map_cid ON jafc.jafc_template_component_map USING btree (component_id);


--
