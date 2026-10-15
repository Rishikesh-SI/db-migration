-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: ix_labyho_up_gg
-- Type: INDEX

-- Name: ix_labyho_up_gg; Type: INDEX; Schema: labdms; Owner: -
--

CREATE INDEX ix_labyho_up_gg ON labdms.labdms_user_preferences USING btree (guest_guid);


--
