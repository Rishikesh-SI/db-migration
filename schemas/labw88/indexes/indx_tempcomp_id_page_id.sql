-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: indx_tempcomp_id_page_id
-- Type: INDEX

-- Name: indx_tempcomp_id_page_id; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX indx_tempcomp_id_page_id ON labw88.labw88_template_component_data USING btree (template_component_map_id, page_id);


--
