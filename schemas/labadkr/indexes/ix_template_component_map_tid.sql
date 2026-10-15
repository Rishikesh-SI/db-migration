-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labadkr; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labadkr.labadkr_template_component_map USING btree (template_id);


--
