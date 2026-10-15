-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: image_skw_idx
-- Type: INDEX

-- Name: image_skw_idx; Type: INDEX; Schema: labyho; Owner: -
--

CREATE INDEX image_skw_idx ON labyho.labyho_image USING gin (search_keyword);


--
