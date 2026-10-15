-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: ix_labyho_web_user_guid
-- Type: INDEX

-- Name: ix_labyho_web_user_guid; Type: INDEX; Schema: labyho; Owner: -
--

CREATE UNIQUE INDEX ix_labyho_web_user_guid ON labyho.labyho_web_user USING btree (user_guid);


--
