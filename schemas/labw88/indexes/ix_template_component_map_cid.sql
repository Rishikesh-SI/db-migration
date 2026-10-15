-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_template_component_map_cid
-- Type: INDEX

-- Name: ix_template_component_map_cid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_template_component_map_cid ON labw88.labw88_template_component_map USING btree (component_id);


--
