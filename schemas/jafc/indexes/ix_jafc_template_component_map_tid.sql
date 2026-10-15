-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_template_component_map_tid
-- Type: INDEX

-- Name: ix_jafc_template_component_map_tid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_template_component_map_tid ON jafc.jafc_template_component_map USING btree (template_id);


--
