-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: ix_labrao_web_user_guid
-- Type: INDEX

-- Name: ix_labrao_web_user_guid; Type: INDEX; Schema: labirao; Owner: -
--

CREATE UNIQUE INDEX ix_labrao_web_user_guid ON labirao.labirao_web_user USING btree (user_guid);


--
