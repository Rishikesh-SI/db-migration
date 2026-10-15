-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labw88.labw88_template_component_map USING btree (template_id);


--
