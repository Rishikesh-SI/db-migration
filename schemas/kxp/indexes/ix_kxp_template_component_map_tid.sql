-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_template_component_map_tid
-- Type: INDEX

-- Name: ix_kxp_template_component_map_tid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_template_component_map_tid ON kxp.kxp_template_component_map USING btree (template_id);


--
