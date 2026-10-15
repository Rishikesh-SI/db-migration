-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_template_component_map_tid
-- Type: INDEX

-- Name: ix_pbl_template_component_map_tid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_template_component_map_tid ON pbl.pbl_template_component_map USING btree (template_id);


--
