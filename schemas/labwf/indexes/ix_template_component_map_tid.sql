-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labwf; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labwf.labwf_template_component_map USING btree (template_id);


--
