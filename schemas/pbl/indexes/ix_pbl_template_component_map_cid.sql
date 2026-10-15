-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_template_component_map_cid
-- Type: INDEX

-- Name: ix_pbl_template_component_map_cid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_template_component_map_cid ON pbl.pbl_template_component_map USING btree (component_id);


--
