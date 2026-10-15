-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labbsc; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labbsc.labbsc_template_component_map USING btree (template_id);


--
