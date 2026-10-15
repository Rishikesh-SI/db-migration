-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: indx_tempcomp_id_page_id
-- Type: INDEX

-- Name: indx_tempcomp_id_page_id; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX indx_tempcomp_id_page_id ON labpkl_v1.labpkl_v1_template_component_data USING btree (template_component_map_id, page_id);


--
