-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: indx_tempcomp_id_page_id
-- Type: INDEX

-- Name: indx_tempcomp_id_page_id; Type: INDEX; Schema: labkxip; Owner: -
--

CREATE INDEX indx_tempcomp_id_page_id ON labkxip.labkxip_template_component_data USING btree (template_component_map_id, page_id);


--
