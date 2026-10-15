-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_template_component_map_tid
-- Type: INDEX

-- Name: ix_template_component_map_tid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_template_component_map_tid ON labmcfc.labmcfc_template_component_map USING btree (template_id);


--
