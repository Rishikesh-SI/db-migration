-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_template_component_map_tid
-- Type: INDEX

-- Name: ix_cfc_template_component_map_tid; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_template_component_map_tid ON cfc.cfc_template_component_map USING btree (template_id);


--
